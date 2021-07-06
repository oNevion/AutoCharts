const Hapi = require('@hapi/hapi');
const Inert = require('@hapi/inert');
const exportChart = require('./internal');
const server = new Hapi.Server({
    host: 'localhost',
    port: 3000
});

server.route({
    method: 'GET',
    path: '/',
    handler: (request, h) => {
        return h.file('./public/index.html');
    }
});

server.route({
    method: 'GET',
    path: '/{fileName*}',
    handler: (request, h) => {
        return h.file('./public/' + request.params.fileName);
    }
});

const init = async () => {

    await server.register(Inert);
    await server.start();

    console.log(`Server running at: ${server.info.uri}`);
}

server.events.on('start', () => {

    // Start the export feature
    exportChart(server);

    console.log('Server started and the export module is loaded');
});

server.events.on('stop', () => {
    console.log('Server stopped');
});

init();