import { toast as sweetalertToast } from '@/lib/sweetalert';

export function useToast() {
  const toast = ({ title, description, variant = 'default' }) => {
    if (variant === 'destructive') {
      sweetalertToast.error(description, title);
    } else if (variant === 'success') {
      sweetalertToast.success(description, title);
    } else if (variant === 'warning') {
      sweetalertToast.warning(description, title);
    } else {
      sweetalertToast.info(description, title);
    }
  };

  return { toast };
}
