const waitEnter = () => {
  console.log('Aprte para sair');
  process.stdin.setRawMode(true);
  process.stdin.resume();
  process.stdin.on('data', process.exit.bind(process, 0));
};

export default waitEnter;
