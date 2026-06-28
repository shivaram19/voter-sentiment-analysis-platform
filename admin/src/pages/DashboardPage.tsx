import { useQuery } from '@tanstack/react-query';
import { Card, Col, Row, Statistic } from 'antd';
import { getDashboardStats } from '../api/survey.api';

export default function DashboardPage() {
  const { data, isLoading } = useQuery({ queryKey: ['dashboardStats'], queryFn: async () => {
    const res = await getDashboardStats();
    return res.data.data;
  }});

  const stats = data || {};

  return (
    <div>
      <h2>Dashboard</h2>
      <Row gutter={16}>
        <Col span={6}><Card loading={isLoading}><Statistic title="Questionnaires" value={stats.totalQuestionnaires || 0} /></Card></Col>
        <Col span={6}><Card loading={isLoading}><Statistic title="Active" value={stats.activeQuestionnaires || 0} /></Card></Col>
        <Col span={6}><Card loading={isLoading}><Statistic title="Surveyors" value={stats.totalSurveyors || 0} /></Card></Col>
        <Col span={6}><Card loading={isLoading}><Statistic title="Surveys" value={stats.totalSurveys || 0} /></Card></Col>
      </Row>
      <Row gutter={16} style={{ marginTop: 16 }}>
        <Col span={8}><Card loading={isLoading}><Statistic title="Pending Sync" value={stats.pendingSurveys || 0} /></Card></Col>
        <Col span={8}><Card loading={isLoading}><Statistic title="Synced" value={stats.syncedSurveys || 0} /></Card></Col>
        <Col span={8}><Card loading={isLoading}><Statistic title="Failed" value={stats.failedSurveys || 0} /></Card></Col>
      </Row>
    </div>
  );
}
