import React, { useState } from 'react';
import { Button } from './button';

export function AlertDialog({ open, onOpenChange, children }) {
  return (
    <>
      {open && (
        <div className="fixed inset-0 z-50 bg-black/50 flex items-center justify-center">
          <div className="bg-white rounded-lg shadow-lg max-w-sm w-full mx-4">
            {children}
          </div>
        </div>
      )}
    </>
  );
}

export function AlertDialogContent({ children, className = '' }) {
  return (
    <div className={`p-6 ${className}`}>
      {children}
    </div>
  );
}

export function AlertDialogHeader({ children, className = '' }) {
  return (
    <div className={`mb-4 ${className}`}>
      {children}
    </div>
  );
}

export function AlertDialogTitle({ children, className = '' }) {
  return (
    <h2 className={`text-lg font-semibold text-gray-900 ${className}`}>
      {children}
    </h2>
  );
}

export function AlertDialogDescription({ children, className = '' }) {
  return (
    <p className={`text-sm text-gray-600 mt-2 ${className}`}>
      {children}
    </p>
  );
}

export function AlertDialogAction({ children, onClick, disabled = false, className = '' }) {
  return (
    <Button
      onClick={onClick}
      disabled={disabled}
      className={`bg-red-600 hover:bg-red-700 text-white ${className}`}
    >
      {children}
    </Button>
  );
}

export function AlertDialogCancel({ children, className = '' }) {
  return (
    <Button
      variant="outline"
      className={`text-gray-700 border-gray-300 ${className}`}
    >
      {children}
    </Button>
  );
}
