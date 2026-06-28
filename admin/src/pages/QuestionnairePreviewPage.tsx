import { useParams } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { Card, Collapse, Spin } from 'antd';
import { getQuestionnaire } from '../api/questionnaire.api';

export default function QuestionnairePreviewPage() {
  const { id } = useParams<{ id: string }>();
  const { data, isLoading } = useQuery({
    queryKey: ['questionnaire', id],
    queryFn: async () => {
      const res = await getQuestionnaire(id!);
      return res.data.data;
    },
    enabled: !!id,
  });

  if (isLoading) return <Spin />;
  const q = data;

  return (
    <div>
      <h2>{q.title}</h2>
      <p>{q.description}</p>
      <Collapse>
        {q.groups?.map((group: any) => (
          <Collapse.Panel header={group.groupName} key={group.id}>
            {group.questions?.map((question: any) => (
              <Card key={question.id} size="small" style={{ marginBottom: 8 }}>
                <p><strong>{question.questionIdentifier}</strong> ({question.questionType})</p>
                <p>{question.questionText?.en}</p>
              </Card>
            ))}
          </Collapse.Panel>
        ))}
      </Collapse>
    </div>
  );
}
