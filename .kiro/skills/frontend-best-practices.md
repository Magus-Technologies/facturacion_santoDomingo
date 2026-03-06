# Frontend Best Practices Skill

## Propósito
Asegurar que todo código frontend creado siga estándares de calidad, accesibilidad, rendimiento y mantenibilidad.

## Principios Clave

### 1. Estructura y Organización
- Componentes pequeños y reutilizables
- Separación clara de responsabilidades
- Nombres descriptivos y consistentes
- Estructura de carpetas lógica

### 2. Accesibilidad (A11y)
- Usar etiquetas semánticas HTML (`<button>`, `<nav>`, `<main>`, etc.)
- Atributos `aria-*` cuando sea necesario
- Contraste de colores adecuado (WCAG AA mínimo)
- Navegación por teclado funcional
- Textos alternativos en imágenes
- Estructura de headings correcta (h1, h2, h3...)

### 3. Rendimiento
- Lazy loading de imágenes
- Code splitting cuando sea apropiado
- Minimizar re-renders innecesarios
- Optimizar bundle size
- Usar CSS eficiente

### 4. Código Limpio
- Nombres de variables y funciones claros
- Funciones pequeñas y enfocadas
- Evitar código duplicado (DRY)
- Comentarios solo cuando sea necesario
- Indentación y formato consistente

### 5. Responsividad
- Mobile-first approach
- Breakpoints consistentes
- Flexbox/Grid para layouts
- Testear en múltiples dispositivos

### 6. Mantenibilidad
- Usar componentes reutilizables
- Props bien documentadas
- Evitar props drilling excesivo
- Usar composición sobre herencia
- Mantener estado simple

### 7. Testing
- Componentes testables
- Lógica separada de presentación
- Fácil de mockear dependencias

## Checklist al Crear Componentes

- [ ] ¿El componente tiene una responsabilidad clara?
- [ ] ¿Es reutilizable?
- [ ] ¿Tiene nombres descriptivos?
- [ ] ¿Es accesible?
- [ ] ¿Está bien documentado?
- [ ] ¿Maneja estados de error/loading?
- [ ] ¿Es responsive?
- [ ] ¿Evita props drilling?
- [ ] ¿Tiene estilos consistentes?
- [ ] ¿Es performante?

## Checklist al Crear Estilos

- [ ] ¿Usa variables CSS para colores/espacios?
- [ ] ¿Es mobile-first?
- [ ] ¿Evita !important?
- [ ] ¿Tiene suficiente contraste?
- [ ] ¿Es consistente con el diseño?
- [ ] ¿Evita estilos inline?
- [ ] ¿Usa clases semánticas?

## Checklist al Crear Funcionalidad

- [ ] ¿Maneja errores correctamente?
- [ ] ¿Tiene validación de entrada?
- [ ] ¿Es seguro (XSS, CSRF)?
- [ ] ¿Tiene feedback visual (loading, success, error)?
- [ ] ¿Es performante?
- [ ] ¿Está documentado?
- [ ] ¿Es testeable?

## Ejemplos de Buenas Prácticas

### ✅ Componente Bien Estructurado
```jsx
// Nombre descriptivo
function UserCard({ user, onDelete, isLoading }) {
  // Props documentadas
  if (!user) return null;
  
  return (
    <article className="user-card" aria-label={`Usuario: ${user.name}`}>
      <h2>{user.name}</h2>
      <p>{user.email}</p>
      <button 
        onClick={() => onDelete(user.id)}
        disabled={isLoading}
        aria-busy={isLoading}
      >
        {isLoading ? 'Eliminando...' : 'Eliminar'}
      </button>
    </article>
  );
}
```

### ✅ Estilos Bien Organizados
```css
/* Variables reutilizables */
:root {
  --color-primary: #007bff;
  --spacing-unit: 8px;
  --transition: 200ms ease-in-out;
}

/* Mobile-first */
.card {
  padding: var(--spacing-unit);
  background: white;
  border-radius: 4px;
}

/* Breakpoints */
@media (min-width: 768px) {
  .card {
    padding: calc(var(--spacing-unit) * 2);
  }
}
```

## Cuando Crees Algo, Recuerda

1. **Primero**: Piensa en la estructura y responsabilidad
2. **Segundo**: Implementa con accesibilidad en mente
3. **Tercero**: Asegura que sea responsive
4. **Cuarto**: Optimiza rendimiento
5. **Quinto**: Documenta si es necesario
6. **Sexto**: Revisa el checklist

## Recursos Útiles

- [MDN Web Docs](https://developer.mozilla.org/)
- [Web.dev](https://web.dev/)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [CSS Tricks](https://css-tricks.com/)
