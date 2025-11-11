// probe.js
import http from "node:http";
import { performance } from "node:perf_hooks";
import { setTimeout as sleep } from "node:timers/promises";

const url = new URL("http://21.0.0.60:3080/");
const maxRetries = 3;
const baseDelay = 300;
const timeoutMs = 3000;
const maxBytes = 2048;

function attempt() {
  const t0 = performance.now();

  return new Promise((resolve, reject) => {
    const timings = { start: t0, socket: null, connect: null, response: null, end: null };
    const req = http.get(
      {
        hostname: url.hostname,
        port: url.port,
        path: url.pathname,
        method: "GET",
        timeout: timeoutMs,
        headers: {
          "Accept": "text/html,*/*;q=0.8",
          "User-Agent": "duck-probe/1.1"
        }
      },
      (res) => {
        timings.response = performance.now();
        let received = 0;
        const bufs = [];

        res.on("data", (chunk) => {
          if (received >= maxBytes) return;
          const take = Math.min(chunk.length, maxBytes - received);
          bufs.push(chunk.subarray(0, take));
          received += take;
        });

        res.on("end", () => {
          timings.end = performance.now();
          const body = Buffer.concat(bufs).toString("utf8");
          resolve({
            ok: res.statusCode >= 200 && res.statusCode < 400,
            status: res.statusCode,
            headers: {
              server: res.headers["server"] ?? null,
              location: res.headers["location"] ?? null,
              contentType: res.headers["content-type"] ?? null,
            },
            timing_ms: {
              dns_tcp: timings.socket && timings.connect ? +(timings.connect - timings.socket).toFixed(1) : null,
              ttfb: timings.response ? +(timings.response - (timings.connect ?? timings.start)).toFixed(1) : null,
              total: timings.end ? +(timings.end - timings.start).toFixed(1) : null,
            },
            snippet: body.slice(0, 200)
          });
        });
      }
    );

    req.on("socket", (sock) => {
      timings.socket = performance.now();
      sock.on("connect", () => {
        timings.connect = performance.now();
      });
    });

    req.on("timeout", () => req.destroy(new Error("timeout")));
    req.on("error", (err) => {
      const now = performance.now();
      reject(Object.assign(err, {
        timing_ms: {
          total: +(now - t0).toFixed(1),
        }
      }));
    });
  });
}

async function probe() {
  for (let attemptNum = 0; attemptNum <= maxRetries; attemptNum++) {
    try {
      const result = await attempt();
      console.log(JSON.stringify({ attempt: attemptNum, ...result }, null, 2));
      process.exit(result.ok ? 0 : 2);
    } catch (err) {
      console.error(`Attempt ${attemptNum} failed after ${err.timing_ms?.total ?? "?"}ms: ${err.message}`);
      if (attemptNum === maxRetries) process.exit(1);
      await sleep(2 ** attemptNum * baseDelay);
    }
  }
}

probe();
