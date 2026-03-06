import { useState } from 'react';

export function RadioGroup({ value, onValueChange, children, className = '' }) {
    return (
        <div className={`space-y-2 ${className}`}>
            {Array.isArray(children) ? children.map((child, idx) => {
                if (!child) return null;
                return (
                    <div key={idx} onClick={() => {
                        const val = child.props.value;
                        onValueChange?.(val);
                    }}>
                        {child}
                    </div>
                );
            }) : children}
        </div>
    );
}

export function RadioGroupItem({ value, id, checked, onChange }) {
    return (
        <input
            type="radio"
            id={id}
            value={value}
            checked={checked}
            onChange={(e) => onChange?.(e.target.value)}
            className="w-4 h-4 cursor-pointer"
        />
    );
}
