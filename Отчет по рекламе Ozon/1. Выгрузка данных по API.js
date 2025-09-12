function fetchDailyCampaignStatistics() {
 const ss            = SpreadsheetApp.getActiveSpreadsheet();
 const techSheet     = ss.getSheetByName('Технический');
 const outSheetName  = 'Озон Реклама Дневная';

 if (!techSheet)
   throw new Error('Не найден лист "Технический".');

 const dateFrom = formatDateForApi(techSheet.getRange('J2').getValue());
 const dateTo   = formatDateForApi(techSheet.getRange('K2').getValue());
 if (!dateFrom || !dateTo)
   throw new Error('Неверный формат дат в J2-K2 (ожидается дд.ММ.гггг или дата).');

 const token = checkAndRefreshToken();
 if (!token) throw new Error('Не удалось получить токен Performance-API.');

 const out = ss.getSheetByName(outSheetName) || ss.insertSheet(outSheetName);
 out.clear();
 out.appendRow([
   'Campaign ID', 'Title', 'Date',
   'Views', 'Clicks', 'Spent, ₽',
   'Avg Bid, ₽', 'Orders', 'Orders Money, ₽'
 ]);


 const url = 'https://api-performance.ozon.ru/api/client/statistics/daily/json' +
             '?dateFrom=' + encodeURIComponent(dateFrom) +
             '&dateTo=' + encodeURIComponent(dateTo);

 Logger.log('GET ' + url);

 const resp = UrlFetchApp.fetch(url, {
   method : 'get',
   headers: perfHeaders(token),          
   muteHttpExceptions: true,
 });


 const code = resp.getResponseCode();
 const body = resp.getContentText();


 if (code !== 200) {
   Logger.log('Ошибка HTTP ' + code + ': ' + body);
   return;
 }

 let json;
 try {
   json = JSON.parse(body);
 } catch (err) {
   Logger.log('Ошибка JSON: ' + err.message);
   return;
 }

 const arr = json.content || json.data || json.rows || [];
 Logger.log('Получено строк: ' + arr.length);
 if (!arr.length) return;

 const rows = arr.map(r => [
   r.campaignId || r.id || '',
   r.title      || '',
   r.date       || '',
   r.views      || 0,
   r.clicks     || 0,
   r.moneySpent || 0,
   r.avgBid     || 0,
   r.orders     || 0,
   r.ordersMoney|| 0
 ]);


 out.getRange(2, 1, rows.length, rows[0].length).setValues(rows);
 Logger.log('🟢 Записано строк: ' + rows.length);
}

function formatDateForApi(val) {
 if (val instanceof Date)
   return Utilities.formatDate(val, Session.getScriptTimeZone(), 'yyyy-MM-dd');
 const p = String(val).trim().split('.');
 return p.length === 3 ? `${p[2]}-${p[1]}-${p[0]}` : null;
}

function perfHeaders(token) {
     const tech = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Технический');
     return {
       'Authorization': 'Bearer ' + token,
       'Client-Id'    : String(tech.getRange('B4').getValue()).trim(),
       'Api-Key'      : String(tech.getRange('B5').getValue()).trim()
     };
   }
function checkAndRefreshToken() {
var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Технический');
var clientId = String(sheet.getRange('B4').getValue()).trim();
var clientSecret = String(sheet.getRange('B5').getValue()).trim();
var tokenCell = sheet.getRange('B6');
var lastTokenTime = tokenCell.getNote();
var currentTime = new Date().getTime();

Logger.log('Проверка токена. Текущее время: ' + currentTime + ', время получения токена: ' + lastTokenTime);

if (lastTokenTime && currentTime - parseInt(lastTokenTime) < 1800000) {
  Logger.log('Токен еще действителен. Используем сохранённый токен.');
  return tokenCell.getValue();
}

Logger.log('Токен истек или отсутствует. Запрашиваем новый токен.');

var url = 'https://api-performance.ozon.ru/api/client/token';
var payload = {
  'client_id': clientId,
  'client_secret': clientSecret,
  'grant_type': 'client_credentials'
};

var options = {
  'method': 'post',
  'contentType': 'application/json',
  'muteHttpExceptions': true,
  'payload': JSON.stringify(payload)
};

var response = UrlFetchApp.fetch(url, options);
var jsonResponse = JSON.parse(response.getContentText());

if (jsonResponse.access_token) {
  Logger.log('Новый токен получен: ' + jsonResponse.access_token);
  tokenCell.setValue(jsonResponse.access_token);
  tokenCell.setNote(String(currentTime));
  return jsonResponse.access_token;
} else {
  Logger.log('Ошибка при получении токена: ' + JSON.stringify(jsonResponse));
  return null;
}
}








