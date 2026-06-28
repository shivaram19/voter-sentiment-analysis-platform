import { apiClient } from './client';

export const getDashboardStats = () => apiClient.get('/admin/dashboard/stats');

export const listUsers = (page = 0, size = 20) =>
  apiClient.get('/admin/users', { params: { page, size } });

export const createUser = (data: unknown) => apiClient.post('/admin/users', data);

export const updateUser = (id: string, data: unknown) =>
  apiClient.put(`/admin/users/${id}`, data);

export const deleteUser = (id: string) => apiClient.delete(`/admin/users/${id}`);
