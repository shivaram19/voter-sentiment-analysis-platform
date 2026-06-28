import { useState } from 'react';
import { Button, Card, message, Typography } from 'antd';
import type { UploadFile } from 'antd/es/upload/interface';
import FileUpload from '../components/FileUpload';
import { uploadQuestionnaire } from '../api/questionnaire.api';

const { Text } = Typography;

export default function QuestionnaireUploadPage() {
  const [fileList, setFileList] = useState<UploadFile[]>([]);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<any>(null);

  const handleUpload = async () => {
    if (fileList.length === 0 || !fileList[0].originFileObj) {
      message.warning('Please select a file');
      return;
    }
    setLoading(true);
    try {
      const res = await uploadQuestionnaire(fileList[0].originFileObj);
      setResult(res.data.data);
      if (res.data.data.validation.valid) {
        message.success('File is valid. Review and save from the preview page.');
      } else {
        message.error('Validation failed. See details below.');
      }
    } catch (err: any) {
      message.error(err.response?.data?.message || 'Upload failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>Upload Questionnaire</h2>
      <Card style={{ marginBottom: 16 }}>
        <FileUpload
          accept=".xlsx,.xls"
          fileList={fileList}
          setFileList={setFileList}
        />
        <Button type="primary" onClick={handleUpload} loading={loading} style={{ marginTop: 16 }}>
          Validate & Preview
        </Button>
      </Card>
      {result && (
        <Card title="Validation Result">
          <p><strong>Valid:</strong> {result.validation.valid ? 'Yes' : 'No'}</p>
          {result.validation.errors.length > 0 && (
            <>
              <Text type="danger">Errors:</Text>
              <ul>{result.validation.errors.map((e: string, i: number) => <li key={i}>{e}</li>)}</ul>
            </>
          )}
          {result.validation.warnings.length > 0 && (
            <>
              <Text type="warning">Warnings:</Text>
              <ul>{result.validation.warnings.map((w: string, i: number) => <li key={i}>{w}</li>)}</ul>
            </>
          )}
        </Card>
      )}
    </div>
  );
}
