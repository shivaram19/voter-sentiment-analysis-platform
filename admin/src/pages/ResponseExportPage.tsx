import { useState } from 'react';
import { Button, Select, message } from 'antd';
import { useQuery } from '@tanstack/react-query';
import { exportResponses, listQuestionnaires } from '../api/questionnaire.api';

export default function ResponseExportPage() {
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const { data } = useQuery({
    queryKey: ['questionnaires'],
    queryFn: async () => {
      const res = await listQuestionnaires(0, 1000);
      return res.data.data.content;
    },
  });

  const handleExport = async () => {
    if (!selectedId) {
      message.warning('Select a questionnaire');
      return;
    }
    setLoading(true);
    try {
      const res = await exportResponses(selectedId);
      const blob = new Blob([res.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'responses.xlsx';
      a.click();
      window.URL.revokeObjectURL(url);
      message.success('Export downloaded');
    } catch {
      message.error('Export failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>Export Responses</h2>
      <Select
        style={{ width: 300, marginRight: 16 }}
        placeholder="Select questionnaire"
        options={data?.map((q: any) => ({ value: q.id, label: q.title }))}
        onChange={setSelectedId}
      />
      <Button type="primary" loading={loading} onClick={handleExport}>Download Excel</Button>
    </div>
  );
}
