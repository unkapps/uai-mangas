import 'reflect-metadata';
import { container } from 'tsyringe';

import waitEnter from './util/wait-enter';
import Extrator from './extrator';

const main: Function = () => {
  try {
    const ext: Extrator = container.resolve(Extrator);
    const args = process.argv.slice(2);
    ext.run(args.map((arg) => arg.toLowerCase()));
  } catch (err) {
    console.error(err);
    waitEnter();
  }
};

main();
