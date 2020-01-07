import { networkInterfaces } from 'os'
export default function() {
    const ifaces = networkInterfaces();
    let ip = '';
    for (let dev in ifaces) {
        for (let i = 0; i < ifaces[dev].length; i++) {
            if (!ifaces[dev][i].internal && ifaces[dev][i].family === 'IPv4' && !ifaces[dev][i].address.includes('::') && ifaces[dev][i].address !== '127.0.0.1') {
                ip = ifaces[dev][i].address;
                break;
            }
        }
    }
    return ip + ':3000';
}