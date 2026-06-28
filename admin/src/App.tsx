import { useEffect, useState } from 'react';
import { Spin } from 'antd';
import AppRoutes from './routes';
import { useAuthStore } from './utils/auth.store';
import { apiClient } from './api/client';

function App() {
  const { token, setUser } = useAuthStore();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const init = async () => {
      if (token) {
        try {
          const res = await apiClient.get('/auth/me');
          setUser(res.data.data);
        } catch {
          // token invalid; user will be redirected by routes
        }
      }
      setLoading(false);
    };
    init();
  }, [token, setUser]);

  if (loading) {
    return (
      <div style={{ height: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <Spin size="large" />
      </div>
    );
  }

  return <AppRoutes />;
}

export default App;
