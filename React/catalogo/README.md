# React + TypeScript + Vite
# by: Treuk, Velislei A
#   email: velislei@gmail.com
#   whats: +55(42)9 8404-0687
#   github.com/velislei-code/Portfolio/
#   linkedin.com/in/velislei-adilson-treuk-75131323/
#   Copyright(c) Treuk, Velislei A. mar2026
#   catálogo de peças - App Frontend
#   Simples projeto de demonstração de conexão Backend Api javaSpring com Frontend em React, vite, typeScript
#   All Rights Reserveds       
# Requisitos
1 - Instale o Node.js e o NPM em sua máquina
2 - No terminal criamos 1 novo projeto React com vite
    npm install
    2.1 - npm create vite@latest   // latest é para pegar a ultima versão do vite
        projeto name:
        [x]React
        [x]TypeScript
    2.2 - npm install
    2.3 - npm run dev             // rodar nosso React
        http://127.0.0.1:5173/  // Testar

* Todas as dependências, criadas, podem ser visualizadas em: package.json
    Note que, qdo em produção, somente a dependencia react-dom vai existir
    todas as demais são só ambiente de desenvolvimento, ou seja, não compiladas

3 - Para Pegar os dados do backEnd(via API) - instalamos um Library
    Terminal> npm install tanstack-query/react-query

4 - Para Disparar requisições Http, instale:
    Terminal> npm install axios
# -----------------------------------------------------------------------------------------------------------------

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Oxc](https://oxc.rs)
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/)

## React Compiler

The React Compiler is not enabled on this template because of its impact on dev & build performances. To add it, see [this documentation](https://react.dev/learn/react-compiler/installation).

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type-aware lint rules:

```js
export default defineConfig([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...

      // Remove tseslint.configs.recommended and replace with this
      tseslint.configs.recommendedTypeChecked,
      // Alternatively, use this for stricter rules
      tseslint.configs.strictTypeChecked,
      // Optionally, add this for stylistic rules
      tseslint.configs.stylisticTypeChecked,

      // Other configs...
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default defineConfig([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs['recommended-typescript'],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```
