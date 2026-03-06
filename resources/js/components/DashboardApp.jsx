import React from "react";
import MainLayout from "./Layout/MainLayout";
import DashboardPage from "./Dashboard/DashboardPage";

export default function DashboardApp() {
    return (
        <MainLayout>
            <DashboardPage />
        </MainLayout>
    );
}
