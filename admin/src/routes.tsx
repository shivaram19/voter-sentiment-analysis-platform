import { Routes, Route, Navigate } from 'react-router-dom';
import { useAuthStore } from './utils/auth.store';
import Layout from './components/Layout';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import QuestionnaireUploadPage from './pages/QuestionnaireUploadPage';
import QuestionnaireListPage from './pages/QuestionnaireListPage';
import QuestionnairePreviewPage from './pages/QuestionnairePreviewPage';
import ResponseExportPage from './pages/ResponseExportPage';
import SurveyorManagementPage from './pages/SurveyorManagementPage';

function ProtectedRoute({ children }: { children: JSX.Element }) {
  const { token } = useAuthStore();
  return token ? children : <Navigate to="/login" replace />;
}

export default function AppRoutes() {
  const { token } = useAuthStore();

  return (
    <Routes>
      <Route path="/login" element={token ? <Navigate to="/" replace /> : <LoginPage />} />
      <Route
        path="/"
        element={
          <ProtectedRoute>
            <Layout />
          </ProtectedRoute>
        }
      >
        <Route index element={<DashboardPage />} />
        <Route path="upload" element={<QuestionnaireUploadPage />} />
        <Route path="questionnaires" element={<QuestionnaireListPage />} />
        <Route path="questionnaires/:id" element={<QuestionnairePreviewPage />} />
        <Route path="export" element={<ResponseExportPage />} />
        <Route path="surveyors" element={<SurveyorManagementPage />} />
      </Route>
    </Routes>
  );
}
