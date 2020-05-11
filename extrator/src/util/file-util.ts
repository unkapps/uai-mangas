import fs from 'fs';
import util from 'util';
import axios, { AxiosResponse } from 'axios';
import imagemin from 'imagemin';
import imageminJpegtran from 'imagemin-jpegtran';
import imageminPngquant from 'imagemin-pngquant';

import { Stream } from 'stream';

export const writeFile = util.promisify(fs.writeFile);
export const fileExists = util.promisify(fs.exists);
export const readFile = util.promisify(fs.readFile);
export const unlink = util.promisify(fs.unlink);
export const mkdir = util.promisify(fs.mkdir);

export const saveFileFromHttp = async (fileUrl: string, fileName: string, pathWithoutFile): Promise<string> => {
  const response: AxiosResponse<Stream> = await axios.get(fileUrl, {
    responseType: 'stream',
  });

  await mkdir(pathWithoutFile, { recursive: true });

  const path = `${pathWithoutFile}${fileName}${this.getExtension(fileUrl)}`;
  const writer = fs.createWriteStream(path);

  response.data.pipe(writer);

  return new Promise<string>((resolve, reject) => {
    writer.on('finish', () => resolve(path));
    writer.on('error', reject);
  });
};

export const saveImageFromHttp = saveFileFromHttp;

export const compressImage = async (path): Promise<any> => {
  return imagemin([`${path}/*.{jpg,png}`], {
    destination: path,
    plugins: [
      imageminJpegtran(),
      imageminPngquant({
        quality: [0.6, 0.8],
      }),
    ],
  });
};

export const getExtension = (filename) => {
  const index = filename.lastIndexOf('.');
  return (index < 0) ? '' : filename.substr(index);
};
