import {
    SubscribeMessage,
    WebSocketGateway,
    WebSocketServer,
    OnGatewayInit,
    OnGatewayConnection,
    OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Client, Server } from 'socket.io';

@WebSocketGateway({ namespace: 'comment' })
export class CommentGateway implements
    OnGatewayInit,
    OnGatewayConnection,
    OnGatewayDisconnect { // 实现生命周期的接口

    constructor() { }

    @WebSocketServer()
    server: Server // server实例,在这里即namespace为'/'的server
    afterInit(server: Server) {
        console.log('init')
    }
    handleConnection(client: Client) {
        console.log('co')
    }
    handleDisconnect(client: Client) {
    }
    // 注册事件
    @SubscribeMessage('event')
    handle(client: Client, data: any) {
        this.server.emit('event', data) // 在当前命名空间下广播事件
    }
}