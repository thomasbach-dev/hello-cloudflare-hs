// -*- mode: javascript -*-
import * as rts from "./rts.mjs";
import hello_cloudflare from "./hello-cloudflare.req.mjs";

async function handleRequest(req) {
  const i = await rts.newAsteriusInstance(Object.assign(hello_cloudflare, { module: WASM }));
  const body = await req.text();
  return await i.exports.handleReq(req);
}

addEventListener("fetch", event => {
  event.respondWith(handleRequest(event.request))
});
