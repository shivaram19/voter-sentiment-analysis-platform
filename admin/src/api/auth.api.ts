import { apiClient } from './client';

export interface LoginPayload {
  username: string;
  password: string;
}

export const login = (payload: LoginPayload) => apiClient.post('/auth/login', payload);

export const getMe = () => apiClient.get('/auth/me');
