import fs from 'fs';
import util from 'util';

export const writeFile = util.promisify(fs.writeFile);
export const fileExists = util.promisify(fs.exists);
export const readFile = util.promisify(fs.readFile);
