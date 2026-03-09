import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'

// Clarity
(function (c: any, l: Document, a: string, r: string, i: string, t?: any, y?: any) {
  c[a] =
    c[a] ||
    function () {
      (c[a].q = c[a].q || []).push(arguments)
    }
  t = l.createElement(r)
  t.async = 1
  t.src = 'https://www.clarity.ms/tag/' + i
  y = l.getElementsByTagName(r)[0]
  y.parentNode!.insertBefore(t, y)
})(window, document, 'clarity', 'script', 'vtag7yal81')

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>
)