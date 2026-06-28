import { useQuery } from '@tanstack/react-query';
import { Button, Space, message } from 'antd';
import { useNavigate } from 'react-router-dom';
import DataTable from '../components/DataTable';
import StatusBadge from '../components/StatusBadge';
import { activateQuestionnaire, deactivateQuestionnaire, deleteQuestionnaire, listQuestionnaires } from '../api/questionnaire.api';

export default function QuestionnaireListPage() {
  const navigate = useNavigate();
  const { data, isLoading, refetch } = useQuery({
    queryKey: ['questionnaires'],
    queryFn: async () => {
      const res = await listQuestionnaires();
      return res.data.data.content;
    },
  });

  const toggle = async (id: string, active: boolean) => {
    try {
      if (active) await deactivateQuestionnaire(id);
      else await activateQuestionnaire(id);
      message.success('Status updated');
      refetch();
    } catch {
      message.error('Update failed');
    }
  };

  const remove = async (id: string) => {
    try {
      await deleteQuestionnaire(id);
      message.success('Deleted');
      refetch();
    } catch {
      message.error('Delete failed');
    }
  };

  const columns = [
    { title: 'Title', dataIndex: 'title', key: 'title' },
    { title: 'Active', dataIndex: 'active', key: 'active', render: (v: boolean) => <StatusBadge status={v} /> },
    { title: 'Updated', dataIndex: 'updatedAt', key: 'updatedAt' },
    {
      title: 'Actions',
      key: 'actions',
      render: (_: any, record: any) => (
        <Space>
          <Button size="small" onClick={() => navigate(`/questionnaires/${record.id}`)}>Preview</Button>
          <Button size="small" onClick={() => toggle(record.id, record.active)}>
            {record.active ? 'Deactivate' : 'Activate'}
          </Button>
          <Button size="small" danger onClick={() => remove(record.id)}>Delete</Button>
        </Space>
      ),
    },
  ];

  return (
    <div>
      <h2>Questionnaires</h2>
      <DataTable columns={columns} data={data || []} loading={isLoading} />
    </div>
  );
}
