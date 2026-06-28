import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Button, Form, Input, Modal, Select, Space, message } from 'antd';
import { useState } from 'react';
import DataTable from '../components/DataTable';
import { createUser, deleteUser, listUsers, updateUser } from '../api/survey.api';

const ROLES = ['ADMIN', 'SUPERVISOR', 'SURVEYOR'];

export default function SurveyorManagementPage() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editing, setEditing] = useState<any>(null);
  const [form] = Form.useForm();
  const queryClient = useQueryClient();

  const { data, isLoading } = useQuery({
    queryKey: ['users'],
    queryFn: async () => {
      const res = await listUsers();
      return res.data.data.content;
    },
  });

  const saveMutation = useMutation({
    mutationFn: async (values: any) => {
      if (editing) return updateUser(editing.id, values);
      return createUser(values);
    },
    onSuccess: () => {
      message.success('Saved');
      setIsModalOpen(false);
      form.resetFields();
      setEditing(null);
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
    onError: () => message.error('Save failed'),
  });

  const deleteMutation = useMutation({
    mutationFn: deleteUser,
    onSuccess: () => {
      message.success('Deleted');
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });

  const openEdit = (record: any) => {
    setEditing(record);
    form.setFieldsValue(record);
    setIsModalOpen(true);
  };

  const columns = [
    { title: 'Username', dataIndex: 'username', key: 'username' },
    { title: 'Name', dataIndex: 'name', key: 'name' },
    { title: 'Role', dataIndex: 'role', key: 'role' },
    { title: 'Region', dataIndex: 'assignedRegion', key: 'assignedRegion' },
    {
      title: 'Actions',
      key: 'actions',
      render: (_: any, record: any) => (
        <Space>
          <Button size="small" onClick={() => openEdit(record)}>Edit</Button>
          <Button size="small" danger onClick={() => deleteMutation.mutate(record.id)}>Delete</Button>
        </Space>
      ),
    },
  ];

  return (
    <div>
      <h2>Surveyor Management</h2>
      <Button type="primary" style={{ marginBottom: 16 }} onClick={() => { setEditing(null); form.resetFields(); setIsModalOpen(true); }}>
        Add User
      </Button>
      <DataTable columns={columns} data={data || []} loading={isLoading} />
      <Modal
        title={editing ? 'Edit User' : 'Add User'}
        open={isModalOpen}
        onCancel={() => setIsModalOpen(false)}
        onOk={() => form.submit()}
      >
        <Form form={form} layout="vertical" onFinish={(values) => saveMutation.mutate(values)}>
          <Form.Item label="Username" name="username" rules={[{ required: true }]}>
            <Input disabled={!!editing} />
          </Form.Item>
          {!editing && (
            <Form.Item label="Password" name="password" rules={[{ required: true }]}>
              <Input.Password />
            </Form.Item>
          )}
          <Form.Item label="Name" name="name" rules={[{ required: true }]}>
            <Input />
          </Form.Item>
          <Form.Item label="Email" name="email">
            <Input />
          </Form.Item>
          <Form.Item label="Role" name="role" rules={[{ required: true }]}>
            <Select options={ROLES.map(r => ({ value: r, label: r }))} />
          </Form.Item>
          <Form.Item label="Assigned Region" name="assignedRegion">
            <Input />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
}
