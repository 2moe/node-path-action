import { appendFileSync } from "node:fs";
import process from "node:process";

const exePath = process.execPath;
console.info(exePath);
console.debug(
    'You can use ${{steps."action-id".outputs.exe}} to get the output (please replace "action-id" with the specific id)',
);
appendFileSync(process.env.GITHUB_OUTPUT, `exe=${exePath}`);
