import proxy from "http-proxy-middleware";

export default function (app: any) {
    app.use(
        proxy("/api", {
            target: "http://127.0.0.1:3000",
            changeOrigin: true
        })
    );
}