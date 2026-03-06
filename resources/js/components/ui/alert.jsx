import React from 'react';

export function Alert({ children, variant = 'default', className = '' }) {
  const baseStyles = 'rounded-lg border p-4 flex gap-3';
  
  const variantStyles = {
    default: 'bg-blue-50 border-blue-200 text-blue-900',
    destructive: 'bg-red-50 border-red-200 text-red-900',
    warning: 'bg-yellow-50 border-yellow-200 text-yellow-900',
    success: 'bg-green-50 border-green-200 text-green-900',
  };

  return (
    <div className={`${baseStyles} ${variantStyles[variant]} ${className}`}>
      {children}
    </div>
  );
}

export function AlertDescription({ children, className = '' }) {
  return (
    <div className={`text-sm ${className}`}>
      {children}
    </div>
  );
}

export function AlertTitle({ children, className = '' }) {
  return (
    <h5 className={`font-semibold mb-1 ${className}`}>
      {children}
    </h5>
  );
}
