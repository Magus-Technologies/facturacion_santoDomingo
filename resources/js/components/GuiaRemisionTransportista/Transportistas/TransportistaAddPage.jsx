import { useState } from 'react';
import MainLayout from '@/components/Layout/MainLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { ArrowLeft, Truck } from 'lucide-react';
import { TransportistaForm } from './TransportistaForm';
import api from '@/services/api';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from "@/lib/baseUrl";

export function TransportistaAddPage() {
    const [isLoading, setIsLoading] = useState(false);

    const handleSubmit = async (data, setErrors) => {
        setIsLoading(true);
        try {
            await api.post('/transportistas', data);
            toast.success('Transportista creado correctamente');
            window.location.href = baseUrl('/facturacion/transportistas');
        } catch (error) {
            if (error.response?.status === 422) {
                setErrors(error.response.data.errors || {});
            } else {
                toast.error(error.response?.data?.message || 'Error al crear el transportista');
            }
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <MainLayout>
            <div className="mb-6">
                <nav className="text-sm text-gray-500 mb-2">
                    <a href={baseUrl("/facturacion/transportistas")} className="hover:text-primary-600">
                        Transportistas
                    </a>
                    <span className="mx-2">/</span>
                    <span className="text-gray-900">Nuevo</span>
                </nav>
                <div className="flex items-center justify-between">
                    <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-3">
                        <Truck className="h-6 w-6 text-primary-600" />
                        Nuevo Transportista
                    </h1>
                    <Button variant="outline" onClick={() => (window.location.href = baseUrl('/facturacion/transportistas'))}>
                        <ArrowLeft className="h-4 w-4 mr-2" />
                        Regresar
                    </Button>
                </div>
            </div>

            <div className="max-w-2xl">
                <Card>
                    <CardHeader className="bg-primary-600 rounded-t-lg">
                        <CardTitle className="text-base text-white flex items-center gap-2">
                            <Truck className="h-4 w-4" />
                            Datos del Transportista
                        </CardTitle>
                    </CardHeader>
                    <CardContent className="pt-4">
                        <TransportistaForm onSubmit={handleSubmit} isLoading={isLoading} />
                    </CardContent>
                </Card>
            </div>
        </MainLayout>
    );
}
