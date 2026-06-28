import { Tag } from 'antd';

interface StatusBadgeProps {
  status: boolean | string;
}

export default function StatusBadge({ status }: StatusBadgeProps) {
  if (typeof status === 'boolean') {
    return <Tag color={status ? 'green' : 'default'}>{status ? 'Active' : 'Inactive'}</Tag>;
  }
  const colorMap: Record<string, string> = {
    PENDING: 'orange',
    SYNCED: 'green',
    FAILED: 'red',
  };
  return <Tag color={colorMap[status] || 'default'}>{status}</Tag>;
}
