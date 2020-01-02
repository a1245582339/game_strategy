
export function formatDate(time: number) {
    const data = new Date(time)
    const year = data.getFullYear();  //取得4位数的年份
    const month = padding0(data.getMonth() + 1);  //取得日期中的月份，其中0表示1月，11表示12月
    const date = padding0(data.getDate());      //返回日期月份中的天数（1到31）
    const hour = padding0(data.getHours());     //返回日期中的小时数（0到23）
    const minute = padding0(data.getMinutes()); //返回日期中的分钟数（0到59）
    const second = padding0(data.getSeconds()); //返回日期中的秒数（0到59）
    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
}
function padding0(n: number) {
    return n < 10 ? '0' + n : n
}  