class SupabaseConfig {
  // Replace with your Supabase project credentials
  static const String supabaseUrl = 'https://cezqbdpqxvhevxoclsbl.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlenFiZHBxeHZoZXZ4b2Nsc2JsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM4MzIwOTYsImV4cCI6MjA3OTQwODA5Nn0.qt7hYEuKWSm2gyqZ-JDTbfucIDli4qmjs8OnHCnp18A';

  // Table names
  static const String usersTable = 'users';
  static const String challansTable = 'challans';
  static const String tokensTable = 'tokens';
  static const String reprintRequestsTable = 'reprint_requests';
  static const String activityLogsTable = 'activity_logs';
  static const String vehiclesTable = 'vehicles';
  static const String systemSettingsTable = 'system_settings';
}
// -- Enable UUID extension
// CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
//
// -- Users table
// CREATE TABLE users (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// email TEXT UNIQUE NOT NULL,
// full_name TEXT NOT NULL,
// role TEXT NOT NULL CHECK (role IN ('super_admin', 'admin', 'user', 'viewer')),
// status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'blocked')),
// phone TEXT,
// created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
// created_by UUID REFERENCES users(id),
// last_login TIMESTAMP WITH TIME ZONE,
// device_info JSONB,
// ip_address TEXT
// );
//
// -- Tokens table (CREATE FIRST before challans)
// CREATE TABLE tokens (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// token_number TEXT UNIQUE NOT NULL,
// status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'used', 'expired')),
// valid_from TIMESTAMP WITH TIME ZONE NOT NULL,
// valid_until TIMESTAMP WITH TIME ZONE NOT NULL,
// vehicle_number TEXT,
// created_by UUID REFERENCES users(id),
// created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
// used_at TIMESTAMP WITH TIME ZONE,
// used_by UUID REFERENCES users(id)
// );
//
// -- Challans table (NOW tokens exists → NO ERROR)
// CREATE TABLE challans (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// challan_number TEXT UNIQUE NOT NULL,
// vehicle_number TEXT NOT NULL,
// vehicle_type TEXT NOT NULL,
// driver_name TEXT NOT NULL,
// driver_phone TEXT,
// material_type TEXT NOT NULL,
// weight DECIMAL(10,2) NOT NULL,
// rate DECIMAL(10,2) NOT NULL,
// total_amount DECIMAL(10,2) NOT NULL,
// token_id UUID REFERENCES tokens(id),
// created_by UUID REFERENCES users(id) NOT NULL,
// created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
// print_count INTEGER DEFAULT 0,
// last_printed_at TIMESTAMP WITH TIME ZONE,
// qr_code TEXT NOT NULL,
// status TEXT DEFAULT 'active' CHECK (status IN ('active', 'cancelled')),
// remarks TEXT
// );
//
// -- Reprint requests table
// CREATE TABLE reprint_requests (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// challan_id UUID REFERENCES challans(id) NOT NULL,
// requested_by UUID REFERENCES users(id) NOT NULL,
// requested_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
// reason TEXT NOT NULL,
// status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
// reviewed_by UUID REFERENCES users(id),
// reviewed_at TIMESTAMP WITH TIME ZONE,
// review_notes TEXT
// );
//
// -- Activity logs table
// CREATE TABLE activity_logs (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// user_id UUID REFERENCES users(id) NOT NULL,
// action TEXT NOT NULL,
// entity_type TEXT NOT NULL,
// entity_id UUID,
// details JSONB,
// ip_address TEXT,
// device_info JSONB,
// created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
// );
//
// -- Vehicles table
// CREATE TABLE vehicles (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// vehicle_number TEXT UNIQUE NOT NULL,
// vehicle_type TEXT NOT NULL,
// last_challan_at TIMESTAMP WITH TIME ZONE,
// total_challans INTEGER DEFAULT 0,
// created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
// );
//
// -- System settings table
// CREATE TABLE system_settings (
// id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
// setting_key TEXT UNIQUE NOT NULL,
// setting_value JSONB NOT NULL,
// updated_by UUID REFERENCES users(id),
// updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
// );
//
// -- Indexes
// CREATE INDEX idx_challans_vehicle ON challans(vehicle_number);
// CREATE INDEX idx_challans_created_at ON challans(created_at DESC);
// CREATE INDEX idx_challans_created_by ON challans(created_by);
// CREATE INDEX idx_tokens_vehicle ON tokens(vehicle_number);
// CREATE INDEX idx_activity_logs_user ON activity_logs(user_id);
// CREATE INDEX idx_activity_logs_created_at ON activity_logs(created_at DESC);
//
// -- Default settings
// INSERT INTO system_settings (setting_key, setting_value) VALUES
// ('challan_time_limit', '{"hours": 6}'::jsonb),
// ('auto_approve_after_hours', '{"enabled": true, "hours": 6}'::jsonb),
// ('require_2fa', '{"enabled": false}'::jsonb),
// ('qr_verification', '{"enabled": true}'::jsonb);
//
// -- RLS (Row Level Security)
// ALTER TABLE users ENABLE ROW LEVEL SECURITY;
// ALTER TABLE challans ENABLE ROW LEVEL SECURITY;
// ALTER TABLE tokens ENABLE ROW LEVEL SECURITY;
// ALTER TABLE reprint_requests ENABLE ROW LEVEL SECURITY;
// ALTER TABLE activity_logs ENABLE ROW LEVEL SECURITY;
// ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;
// ALTER TABLE system_settings ENABLE ROW LEVEL SECURITY;
//
// -- Policies
// CREATE POLICY users_select_own ON users FOR SELECT USING (auth.uid()::uuid = id);
//
// CREATE POLICY users_super_admin ON users FOR ALL USING (
// EXISTS (SELECT 1 FROM users WHERE id = auth.uid()::uuid AND role = 'super_admin')
// );
//
// CREATE POLICY users_admin_manage ON users FOR ALL USING (
// EXISTS (SELECT 1 FROM users WHERE id = auth.uid()::uuid AND role IN ('super_admin', 'admin'))
// AND role NOT IN ('super_admin', 'admin')
// );
//
// CREATE POLICY challans_select ON challans FOR SELECT USING (true);
//
// CREATE POLICY challans_insert ON challans FOR INSERT WITH CHECK (
// EXISTS (SELECT 1 FROM users WHERE id = auth.uid()::uuid AND role IN ('user', 'admin', 'super_admin'))
// );
//
// CREATE POLICY challans_update ON challans FOR UPDATE USING (
// EXISTS (SELECT 1 FROM users WHERE id = auth.uid()::uuid AND role IN ('admin', 'super_admin'))
// );
//
// CREATE POLICY tokens_all ON tokens FOR ALL USING (auth.role() = 'authenticated');
// CREATE POLICY reprint_requests_all ON reprint_requests FOR ALL USING (auth.role() = 'authenticated');
// CREATE POLICY activity_logs_all ON activity_logs FOR ALL USING (auth.role() = 'authenticated');
// CREATE POLICY vehicles_all ON vehicles FOR ALL USING (auth.role() = 'authenticated');
// CREATE POLICY system_settings_all ON system_settings FOR ALL USING (auth.role() = 'authenticated');
