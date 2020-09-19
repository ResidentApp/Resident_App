async function classify_comment(comment) {
  const { google } = require("googleapis");
  const API_KEY = "AIzaSyDvG3vlovfaGB-ZxN27LHIIFbuzIRr6sz0";
  const DISCOVERY_URL =
    "https://commentanalyzer.googleapis.com/$discovery/rest?version=v1alpha1";
  const client = await google.discoverAPI(DISCOVERY_URL);
  const resp = await client.comments.analyze({
    key: API_KEY,
    resource: {
      comment: {
        text: "Trump is an idiot",
      },
      requestedAttributes: {
        TOXICITY: {},
      },
    },
    requestedAttributes: {
      TOXICITY: {},
    },
  });

  if (resp.data.attributeScores.TOXICITY.spanScores[0].score.value > 0.45) {
    return true;
  } else {
    return false;
  }
}
async function classify_image(img_link) {
  const axios = require("axios").default; // install request module by - 'npm install request'
  const querystring = require("querystring");

  const form_data = {
    modelId: "e4745b0e-70fb-447e-8870-61566137c8ab",
    urls: img_link,
  };

  const options = {
    headers: {
      Authorization:
        "Basic " +
        Buffer.from("-haYmFRR1siZGxd6GqF0fB3frdMLXqV5" + ":").toString(
          "base64"
        ),
      "Content-Type": "application/x-www-form-urlencoded",
    },
  };

  const resp = await axios.post(
    "https://app.nanonets.com/api/v2/ImageCategorization/LabelUrls/",
    querystring.stringify(form_data),
    options
  );
  const body = resp.data;
  if (body.result[0].prediction[0].probability < 0.6) return true;
  return false;
}
module.exports = {classify_comment, classify_image}
