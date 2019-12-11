import * as redis from 'redis';
const client = redis.createClient();
export const getRedis = (key: string) => new Promise((resolve:(value: string) => void, reject) => {
    client.get(key, (err, res) => {
        if (err) reject(err)
        resolve(res)
    })
})