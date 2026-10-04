import os
from flask import Flask, jsonify

app = Flask(__name__)

# ─── ENVIRONMENT VARIABLES ──────────────────────
# Sahi tarika — environment se lo
APP_VERSION = os.environ.get('APP_VERSION', '1.0.0')
APP_ENV     = os.environ.get('APP_ENV', 'development')
SECRET_KEY  = os.environ.get('SECRET_KEY', 'default-key')

# ─── ROUTES ─────────────────────────────────────
@app.route('/')
def home():
    return jsonify({
        'message': 'Hello from Secure Python App!',
        'version': APP_VERSION,
        'environment': APP_ENV
    })

@app.route('/health')
def health():
    return jsonify({
        'status': 'healthy',
        'version': APP_VERSION
    })

@app.route('/add/<int:a>/<int:b>')
def add(a, b):
    return jsonify({
        'result': a + b,
        'operation': f'{a} + {b}'
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
