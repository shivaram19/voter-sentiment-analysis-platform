import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu } from 'antd';
import {
  DashboardOutlined,
  UploadOutlined,
  FileTextOutlined,
  DownloadOutlined,
  UserOutlined,
} from '@ant-design/icons';

const { Sider } = Layout;

const items = [
  { key: '/', icon: <DashboardOutlined />, label: <Link to="/">Dashboard</Link> },
  { key: '/upload', icon: <UploadOutlined />, label: <Link to="/upload">Upload</Link> },
  { key: '/questionnaires', icon: <FileTextOutlined />, label: <Link to="/questionnaires">Questionnaires</Link> },
  { key: '/export', icon: <DownloadOutlined />, label: <Link to="/export">Export</Link> },
  { key: '/surveyors', icon: <UserOutlined />, label: <Link to="/surveyors">Surveyors</Link> },
];

export default function Sidebar() {
  const location = useLocation();
  return (
    <Sider theme="light" style={{ borderRight: '1px solid #f0f0f0' }}>
      <div style={{ height: 64, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700 }}>
        VSP
      </div>
      <Menu selectedKeys={[location.pathname]} mode="inline" items={items} />
    </Sider>
  );
}
