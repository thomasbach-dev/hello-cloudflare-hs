// -*- mode: javascript -*-
import * as rts from "./rts.mjs";
import hello_cloudflare_hs from "./hello-cloudflare-hs.req.mjs";

async function handleRequest(req) {
  const i = await rts.newAsteriusInstance(Object.assign(hello_cloudflare_hs, { module: WASM }));
  const body = await req.text();
  return await i.exports.handleReq(req.method, body);
}

addEventListener("fetch", event => {
  event.respondWith(handleRequest(event.request))
});
