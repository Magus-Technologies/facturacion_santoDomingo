import { useState } from "react";
import MainLayout from "../Layout/MainLayout";
import BannerPromocionalPage from "./BannerPromocionalPage";
import GrupoSeleccionPage from "./GrupoSeleccionPage";
import FooterConfigPage from "./FooterConfigPage";

export default function EcommerceApp() {
    const [activeTab, setActiveTab] = useState('banners');

    const tabs = [
        { key: 'banners',   label: 'Banners Promocionales' },
        { key: 'seleccion', label: 'Pestañas de Selección' },
        { key: 'footer',    label: 'Footer / Newsletter' },
    ];

    return (
        <MainLayout>
            <div className="mb-6 border-b border-gray-200">
                <nav className="-mb-px flex space-x-8" aria-label="Tabs">
                    {tabs.map(tab => (
                        <button
                            key={tab.key}
                            onClick={() => setActiveTab(tab.key)}
                            className={`${activeTab === tab.key
                                ? 'border-accent-500 text-accent-600'
                                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                                } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}
                        >
                            {tab.label}
                        </button>
                    ))}
                </nav>
            </div>

            <div className="mt-4">
                {activeTab === 'banners'   && <BannerPromocionalPage />}
                {activeTab === 'seleccion' && <GrupoSeleccionPage />}
                {activeTab === 'footer'    && <FooterConfigPage />}
            </div>
        </MainLayout>
    );
}
