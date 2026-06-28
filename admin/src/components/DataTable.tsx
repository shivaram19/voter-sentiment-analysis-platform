import { Table } from 'antd';
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table';

interface DataTableProps<T> {
  columns: ColumnsType<T>;
  data: T[];
  loading?: boolean;
  pagination?: TablePaginationConfig | false;
  rowKey?: string | ((record: T) => string);
}

export default function DataTable<T extends object>({
  columns,
  data,
  loading,
  pagination = false,
  rowKey = 'id',
}: DataTableProps<T>) {
  return <Table<T> columns={columns} dataSource={data} loading={loading} pagination={pagination} rowKey={rowKey} />;
}
