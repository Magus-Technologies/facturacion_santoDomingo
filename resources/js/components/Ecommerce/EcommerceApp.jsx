import React, { useState } from "react";
import MainLayout from "../Layout/MainLayout";
import BannerPromocionalPage from "./BannerPromocionalPage";
import GrupoSeleccionPage from "./GrupoSeleccionPage";

export default function EcommerceApp() {
    const [activeTab, setActiveTab] = useState('banners');

    return (
        <MainLayout>
            <div className="mb-6 border-b border-gray-200">
                <nav className="-mb-px flex space-x-8" aria-label="Tabs">
                    <button
                        onClick={() => setActiveTab('banners')}
                        className={`${activeTab === 'banners'
                            ? 'border-accent-500 text-accent-600'
                            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                            } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}
                    >
                        Banners Promocionales
                    </button>
                    <button
                        onClick={() => setActiveTab('seleccion')}
                        className={`${activeTab === 'seleccion'
                            ? 'border-accent-500 text-accent-600'
                            : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                            } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}
                    >
                        Pestañas de Selección
                    </button>
                </nav>
            </div>

            <div className="mt-4">
                {activeTab === 'banners' && <BannerPromocionalPage />}
                {activeTab === 'seleccion' && <GrupoSeleccionPage />}
            </div>
        </MainLayout>
    );
}
