from flask import Flask, request, jsonify
import psycopg2
import psycopg2.extras

app = Flask(__name__)

DB = {
    "host": "127.0.0.1",
    "port": 5433,
    "dbname": "noxtua_insights",
    "user": "insights_admin",
    "password": "Noxtua2026",
}
TOKEN = "noxtua-api-2026"

@app.route("/query", methods=["POST"])
def query():
    if request.headers.get("Authorization") != f"Bearer {TOKEN}":
        return jsonify({"error": "unauthorized"}), 401
    sql = request.json.get("sql", "")
    conn = psycopg2.connect(**DB)
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(sql)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([dict(r) for r in rows])

if __name__ == "__main__":
    app.run(port=3001)
