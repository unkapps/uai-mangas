module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: [
    '@typescript-eslint',
  ],
  extends: ['airbnb-typescript/base'],
  parserOptions: {
    project: './tsconfig.json',
  },
  rules: {
    "class-methods-use-this": "off",
    "no-console": "off",
    "arrow-body-style": "off",
    "max-len": ["error", { "code": 140 }]
  },
};
