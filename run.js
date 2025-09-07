import fs from "fs";

process.env.TZ = "Asia/Jakarta";

function getModuleType() {
    try {
        const pkg = JSON.parse(fs.readFileSync("./package.json", "utf8"));
        return pkg.type === "module" ? "module" : "commonjs";
    } catch {
        return "commonjs";
    }
}

async function loadChildProcess() {
    const type = getModuleType();
    if (type === "module") {
        const cp = await import("child_process");
        return cp.spawn;
    } else {
        const { spawn } = require("child_process");
        return spawn;
    }
}

async function start(cmd) {
    try {
        const spawn = await loadChildProcess();
        const colorPrompt = '\\[\\033[1;36m\\]masway@users\\[\\033[0m\\]:\\w\\$ ';

        const childProcess = spawn(cmd, ["-c", `
            export USER="MWPANEL";
            export HOME="/home/container";
            export PS1="${colorPrompt}";
            bash --noprofile --norc
        `], { stdio: "inherit" });

        childProcess.on("error", (error) => {
            console.error("Error starting process:", error.message);
        });

        childProcess.on("exit", (code, signal) => {
            console.log(`Child process exited with code ${code}, signal ${signal}`);
        });
    } catch (error) {
        console.error("Error:", error.message);
    }
}

start("bash");
