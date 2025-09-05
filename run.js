const { spawn } = require('child_process');

process.env.TZ = 'Asia/Jakarta';

function start(cmd) {
    try {
        const colorPrompt = '\\[\\033[1;36m\\]MasWay@users\\[\\033[0m\\]:\\w\\$ ';

        const childProcess = spawn(cmd, ['-c', `
            export USER="MWPANEL";
            export HOME="/home/container";
            export PS1="${colorPrompt}";
            bash --noprofile --norc
        `], {
            stdio: 'inherit'
        });

        childProcess.on('error', (error) => {
            console.error('Error starting process:', error.message);
        });

        childProcess.on('exit', (code, signal) => {
            console.log(`Child process exited with code ${code}, signal ${signal}`);
        });
    } catch (error) {
        console.error('Error:', error.message);
    }
}

start('bash');
