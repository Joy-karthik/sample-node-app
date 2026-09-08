import { createHmac } from "node:crypto";

const webhookUrl =
  "https://event-ai.ap-south-1.api.aws/webhook/generic/48a2e83d-2f76-4957-a4dd-991e6ce1371f";

// Load secret from environment variable (never hardcode!)
const secret = process.env.WEBHOOK_HMAC_SECRET || "";

function sendIncidentToDevOpsAgent() {
  const payload = {
    eventType: "incident",
    incidentId: "INC-001",
    action: "created",
    priority: "HIGH",
    title: "ECS Container health check failing in sample-node-app",
    description:
      "Container exits with code 1, health check failing on /health endpoint",
    timestamp: new Date().toISOString(),
    service: "sample-node-app",
    data: {
      cluster: "sample-node-app-cluster",
      service: "sample-node-app-service",
      region: "ap-south-1",
    },
  };

  const timestamp = new Date().toISOString();
  const hmac = createHmac("sha256", secret);
  hmac.update(`${timestamp}:${JSON.stringify(payload)}`, "utf8");
  const signature = hmac.digest("base64");

  fetch(webhookUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "x-amzn-event-timestamp": timestamp,
      "x-amzn-event-signature": signature,
    },
    body: JSON.stringify(payload),
  });

  console.log("✅ Incident sent to DevOps Agent!");
}

sendIncidentToDevOpsAgent();
