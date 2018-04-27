// function sumdate() {
//     var past = new Date();
//     var future = new Date();
//     past.parse(start_date_leave);
//     future.parse(end_date_leave);
//     var one_day = 1000 * 60 * 60 * 24;
//     var sumDate = (future.getTime() - past.getTime()) / one_day;
//     return sumDate;
// }
function getDate() {
    var froms = new Date(document.getElementById('start_date_leave').value);
    var to = new Date(document.getElementById('end_date_leave').value);
    return parseInt(((to - froms) / (24 * 3600 * 1000)) + 1);
}

function cal() {
    if (document.getElementById('end_date_leave')) {
        document.getElementById('total_day_leave').value = getDate();
    }
}