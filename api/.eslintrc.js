module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2018,
    project: 'tsconfig.json',
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint/eslint-plugin'],
  extends: [
    'airbnb-typescript/base',
  ],
  root: true,
  env: {
    node: true,
    jest: true,
  },
  rules: {
    "class-methods-use-this": "off",
    "no-console": "off",
    "arrow-body-style": "off",
    "import/no-duplicates": "off",
    "no-await-in-loop": "off",
    "no-restricted-syntax": "off",
    "consistent-return": "off",
    "no-underscore-dangle": "off",
    "no-empty": "off",
    "max-len": ["error", { "code": 140 }],
    "import/prefer-default-export": "off",
    "@typescript-eslint/no-unused-vars": "off"
  },
};
