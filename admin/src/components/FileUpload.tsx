import { Upload, Button } from 'antd';
import { UploadOutlined } from '@ant-design/icons';
import type { UploadFile } from 'antd/es/upload/interface';

interface FileUploadProps {
  accept?: string;
  fileList: UploadFile[];
  setFileList: (files: UploadFile[]) => void;
  beforeUpload?: (file: File) => boolean | Promise<boolean>;
}

export default function FileUpload({ accept, fileList, setFileList, beforeUpload }: FileUploadProps) {
  return (
    <Upload
      accept={accept}
      fileList={fileList}
      beforeUpload={(file) => {
        if (beforeUpload) return beforeUpload(file);
        return false; // prevent auto upload
      }}
      onChange={({ fileList: newList }) => setFileList(newList)}
      maxCount={1}
    >
      <Button icon={<UploadOutlined />}>Select File</Button>
    </Upload>
  );
}
