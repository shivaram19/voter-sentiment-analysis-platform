import { apiClient } from './client';

export const listQuestionnaires = (page = 0, size = 20) =>
  apiClient.get('/admin/questionnaire/questionnaires', { params: { page, size } });

export const getQuestionnaire = (id: string) =>
  apiClient.get(`/admin/questionnaire/${id}`);

export const activateQuestionnaire = (id: string) =>
  apiClient.put(`/admin/questionnaire/${id}/activate`);

export const deactivateQuestionnaire = (id: string) =>
  apiClient.put(`/admin/questionnaire/${id}/deactivate`);

export const deleteQuestionnaire = (id: string) =>
  apiClient.delete(`/admin/questionnaire/${id}`);

export const uploadQuestionnaire = (file: File) => {
  const formData = new FormData();
  formData.append('file', file);
  return apiClient.post('/admin/questionnaire/upload', formData, {
    headers: { 'Content-Type': 'multipart/form-data' },
  });
};

export const saveQuestionnaire = (data: unknown) =>
  apiClient.post('/admin/questionnaire/save', data);

export const exportTemplate = (id: string) =>
  apiClient.get(`/admin/questionnaire/${id}/export-template`, { responseType: 'blob' });

export const exportResponses = (id: string) =>
  apiClient.get(`/admin/questionnaire/${id}/export-responses`, { responseType: 'blob' });
