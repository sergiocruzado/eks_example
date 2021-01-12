from flask import Flask, render_template
from datetime import datetime
import socket

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html', 
                            appname="app2",
                            container_name=socket.gethostname(),
                            timestamp=datetime.now().strftime("%d/%m/%Y %H:%M:%S"))

if __name__ == '__main__':
    app.run(host='0.0.0.0')