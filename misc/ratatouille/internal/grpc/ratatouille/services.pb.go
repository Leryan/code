// Code generated by protoc-gen-go. DO NOT EDIT.
// source: services.proto

package ratatouille

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	empty "github.com/golang/protobuf/ptypes/empty"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	math "math"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

type Stuff struct {
	Stuff                string   `protobuf:"bytes,1,opt,name=stuff,proto3" json:"stuff,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Stuff) Reset()         { *m = Stuff{} }
func (m *Stuff) String() string { return proto.CompactTextString(m) }
func (*Stuff) ProtoMessage()    {}
func (*Stuff) Descriptor() ([]byte, []int) {
	return fileDescriptor_8e16ccb8c5307b32, []int{0}
}

func (m *Stuff) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Stuff.Unmarshal(m, b)
}
func (m *Stuff) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Stuff.Marshal(b, m, deterministic)
}
func (m *Stuff) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Stuff.Merge(m, src)
}
func (m *Stuff) XXX_Size() int {
	return xxx_messageInfo_Stuff.Size(m)
}
func (m *Stuff) XXX_DiscardUnknown() {
	xxx_messageInfo_Stuff.DiscardUnknown(m)
}

var xxx_messageInfo_Stuff proto.InternalMessageInfo

func (m *Stuff) GetStuff() string {
	if m != nil {
		return m.Stuff
	}
	return ""
}

type Mother struct {
	Msg                  string   `protobuf:"bytes,1,opt,name=msg,proto3" json:"msg,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Mother) Reset()         { *m = Mother{} }
func (m *Mother) String() string { return proto.CompactTextString(m) }
func (*Mother) ProtoMessage()    {}
func (*Mother) Descriptor() ([]byte, []int) {
	return fileDescriptor_8e16ccb8c5307b32, []int{1}
}

func (m *Mother) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Mother.Unmarshal(m, b)
}
func (m *Mother) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Mother.Marshal(b, m, deterministic)
}
func (m *Mother) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Mother.Merge(m, src)
}
func (m *Mother) XXX_Size() int {
	return xxx_messageInfo_Mother.Size(m)
}
func (m *Mother) XXX_DiscardUnknown() {
	xxx_messageInfo_Mother.DiscardUnknown(m)
}

var xxx_messageInfo_Mother proto.InternalMessageInfo

func (m *Mother) GetMsg() string {
	if m != nil {
		return m.Msg
	}
	return ""
}

type Derp struct {
	Name                 string   `protobuf:"bytes,1,opt,name=name,proto3" json:"name,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Derp) Reset()         { *m = Derp{} }
func (m *Derp) String() string { return proto.CompactTextString(m) }
func (*Derp) ProtoMessage()    {}
func (*Derp) Descriptor() ([]byte, []int) {
	return fileDescriptor_8e16ccb8c5307b32, []int{2}
}

func (m *Derp) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Derp.Unmarshal(m, b)
}
func (m *Derp) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Derp.Marshal(b, m, deterministic)
}
func (m *Derp) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Derp.Merge(m, src)
}
func (m *Derp) XXX_Size() int {
	return xxx_messageInfo_Derp.Size(m)
}
func (m *Derp) XXX_DiscardUnknown() {
	xxx_messageInfo_Derp.DiscardUnknown(m)
}

var xxx_messageInfo_Derp proto.InternalMessageInfo

func (m *Derp) GetName() string {
	if m != nil {
		return m.Name
	}
	return ""
}

type Son struct {
	Msg                  string   `protobuf:"bytes,1,opt,name=msg,proto3" json:"msg,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Son) Reset()         { *m = Son{} }
func (m *Son) String() string { return proto.CompactTextString(m) }
func (*Son) ProtoMessage()    {}
func (*Son) Descriptor() ([]byte, []int) {
	return fileDescriptor_8e16ccb8c5307b32, []int{3}
}

func (m *Son) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Son.Unmarshal(m, b)
}
func (m *Son) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Son.Marshal(b, m, deterministic)
}
func (m *Son) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Son.Merge(m, src)
}
func (m *Son) XXX_Size() int {
	return xxx_messageInfo_Son.Size(m)
}
func (m *Son) XXX_DiscardUnknown() {
	xxx_messageInfo_Son.DiscardUnknown(m)
}

var xxx_messageInfo_Son proto.InternalMessageInfo

func (m *Son) GetMsg() string {
	if m != nil {
		return m.Msg
	}
	return ""
}

type Loudness struct {
	Db                   uint64   `protobuf:"varint,1,opt,name=db,proto3" json:"db,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Loudness) Reset()         { *m = Loudness{} }
func (m *Loudness) String() string { return proto.CompactTextString(m) }
func (*Loudness) ProtoMessage()    {}
func (*Loudness) Descriptor() ([]byte, []int) {
	return fileDescriptor_8e16ccb8c5307b32, []int{4}
}

func (m *Loudness) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Loudness.Unmarshal(m, b)
}
func (m *Loudness) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Loudness.Marshal(b, m, deterministic)
}
func (m *Loudness) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Loudness.Merge(m, src)
}
func (m *Loudness) XXX_Size() int {
	return xxx_messageInfo_Loudness.Size(m)
}
func (m *Loudness) XXX_DiscardUnknown() {
	xxx_messageInfo_Loudness.DiscardUnknown(m)
}

var xxx_messageInfo_Loudness proto.InternalMessageInfo

func (m *Loudness) GetDb() uint64 {
	if m != nil {
		return m.Db
	}
	return 0
}

func init() {
	proto.RegisterType((*Stuff)(nil), "ratatouille.Stuff")
	proto.RegisterType((*Mother)(nil), "ratatouille.Mother")
	proto.RegisterType((*Derp)(nil), "ratatouille.Derp")
	proto.RegisterType((*Son)(nil), "ratatouille.Son")
	proto.RegisterType((*Loudness)(nil), "ratatouille.Loudness")
}

func init() { proto.RegisterFile("services.proto", fileDescriptor_8e16ccb8c5307b32) }

var fileDescriptor_8e16ccb8c5307b32 = []byte{
	// 267 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0x74, 0x8f, 0xcd, 0x4b, 0xc3, 0x40,
	0x10, 0xc5, 0x69, 0x9a, 0x54, 0x1d, 0x69, 0xad, 0xe3, 0x27, 0x11, 0x41, 0x72, 0x12, 0xc1, 0x2d,
	0x54, 0xf1, 0xe2, 0xad, 0xd4, 0x9b, 0x5e, 0x1a, 0xbc, 0x78, 0xcb, 0xc7, 0x24, 0x0d, 0x24, 0x3b,
	0x61, 0x77, 0x23, 0xf8, 0xdf, 0x4b, 0xbe, 0xa0, 0x81, 0xf6, 0xf6, 0x76, 0xde, 0x3e, 0xde, 0xfb,
	0xc1, 0x4c, 0x93, 0xfa, 0xcd, 0x22, 0xd2, 0xa2, 0x54, 0x6c, 0x18, 0x4f, 0x55, 0x60, 0x02, 0xc3,
	0x55, 0x96, 0xe7, 0xe4, 0xde, 0xa5, 0xcc, 0x69, 0x4e, 0x8b, 0xc6, 0x0a, 0xab, 0x64, 0x41, 0x45,
	0x69, 0xfe, 0xda, 0x9f, 0xde, 0x3d, 0x38, 0xbe, 0xa9, 0x92, 0x04, 0x2f, 0xc1, 0xd1, 0xb5, 0xb8,
	0x1d, 0x3d, 0x8c, 0x1e, 0x4f, 0x36, 0xed, 0xc3, 0x73, 0x61, 0xf2, 0xc5, 0x66, 0x4b, 0x0a, 0xe7,
	0x30, 0x2e, 0x74, 0xda, 0xb9, 0xb5, 0xf4, 0x5c, 0xb0, 0xd7, 0xa4, 0x4a, 0x44, 0xb0, 0x65, 0x50,
	0x50, 0x67, 0x35, 0xda, 0xbb, 0x81, 0xb1, 0xcf, 0x72, 0x6f, 0xe8, 0xf8, 0x93, 0xab, 0x58, 0x92,
	0xd6, 0x38, 0x03, 0x2b, 0x0e, 0x1b, 0xd3, 0xde, 0x58, 0x71, 0xb8, 0x34, 0x30, 0x6d, 0xcb, 0xfc,
	0x96, 0x06, 0x9f, 0xc1, 0x5a, 0x33, 0xa2, 0xd8, 0xa1, 0x11, 0xcd, 0x5a, 0xf7, 0x62, 0x70, 0xeb,
	0x26, 0xbe, 0xc2, 0xd1, 0xb7, 0xcc, 0x22, 0x56, 0x12, 0xaf, 0x45, 0x0b, 0x2d, 0x7a, 0x68, 0xf1,
	0x51, 0x43, 0xbb, 0xe7, 0x83, 0x5c, 0x3d, 0x7f, 0x59, 0x02, 0xf8, 0x2c, 0xfb, 0xca, 0xa7, 0x83,
	0x95, 0xf3, 0xe1, 0x8d, 0x25, 0xbe, 0x81, 0xb3, 0xa2, 0x3c, 0xda, 0x1e, 0x6c, 0xbb, 0x1a, 0x44,
	0x7a, 0xee, 0xd5, 0xd9, 0xcf, 0x54, 0xbc, 0xef, 0x38, 0xe1, 0xa4, 0xc9, 0xbd, 0xfc, 0x07, 0x00,
	0x00, 0xff, 0xff, 0x79, 0x56, 0xe2, 0x04, 0xc7, 0x01, 0x00, 0x00,
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion4

// MotherServiceClient is the client API for MotherService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type MotherServiceClient interface {
	Do(ctx context.Context, in *Stuff, opts ...grpc.CallOption) (*Mother, error)
	Unicorn(ctx context.Context, in *empty.Empty, opts ...grpc.CallOption) (*Derp, error)
}

type motherServiceClient struct {
	cc *grpc.ClientConn
}

func NewMotherServiceClient(cc *grpc.ClientConn) MotherServiceClient {
	return &motherServiceClient{cc}
}

func (c *motherServiceClient) Do(ctx context.Context, in *Stuff, opts ...grpc.CallOption) (*Mother, error) {
	out := new(Mother)
	err := c.cc.Invoke(ctx, "/ratatouille.MotherService/Do", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *motherServiceClient) Unicorn(ctx context.Context, in *empty.Empty, opts ...grpc.CallOption) (*Derp, error) {
	out := new(Derp)
	err := c.cc.Invoke(ctx, "/ratatouille.MotherService/Unicorn", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// MotherServiceServer is the server API for MotherService service.
type MotherServiceServer interface {
	Do(context.Context, *Stuff) (*Mother, error)
	Unicorn(context.Context, *empty.Empty) (*Derp, error)
}

// UnimplementedMotherServiceServer can be embedded to have forward compatible implementations.
type UnimplementedMotherServiceServer struct {
}

func (*UnimplementedMotherServiceServer) Do(ctx context.Context, req *Stuff) (*Mother, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Do not implemented")
}
func (*UnimplementedMotherServiceServer) Unicorn(ctx context.Context, req *empty.Empty) (*Derp, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Unicorn not implemented")
}

func RegisterMotherServiceServer(s *grpc.Server, srv MotherServiceServer) {
	s.RegisterService(&_MotherService_serviceDesc, srv)
}

func _MotherService_Do_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Stuff)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(MotherServiceServer).Do(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/ratatouille.MotherService/Do",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(MotherServiceServer).Do(ctx, req.(*Stuff))
	}
	return interceptor(ctx, in, info, handler)
}

func _MotherService_Unicorn_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(empty.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(MotherServiceServer).Unicorn(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/ratatouille.MotherService/Unicorn",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(MotherServiceServer).Unicorn(ctx, req.(*empty.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

var _MotherService_serviceDesc = grpc.ServiceDesc{
	ServiceName: "ratatouille.MotherService",
	HandlerType: (*MotherServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Do",
			Handler:    _MotherService_Do_Handler,
		},
		{
			MethodName: "Unicorn",
			Handler:    _MotherService_Unicorn_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "services.proto",
}

// SonServiceClient is the client API for SonService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type SonServiceClient interface {
	Do(ctx context.Context, in *Stuff, opts ...grpc.CallOption) (*Son, error)
	Belch(ctx context.Context, in *empty.Empty, opts ...grpc.CallOption) (*Loudness, error)
}

type sonServiceClient struct {
	cc *grpc.ClientConn
}

func NewSonServiceClient(cc *grpc.ClientConn) SonServiceClient {
	return &sonServiceClient{cc}
}

func (c *sonServiceClient) Do(ctx context.Context, in *Stuff, opts ...grpc.CallOption) (*Son, error) {
	out := new(Son)
	err := c.cc.Invoke(ctx, "/ratatouille.SonService/Do", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *sonServiceClient) Belch(ctx context.Context, in *empty.Empty, opts ...grpc.CallOption) (*Loudness, error) {
	out := new(Loudness)
	err := c.cc.Invoke(ctx, "/ratatouille.SonService/Belch", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// SonServiceServer is the server API for SonService service.
type SonServiceServer interface {
	Do(context.Context, *Stuff) (*Son, error)
	Belch(context.Context, *empty.Empty) (*Loudness, error)
}

// UnimplementedSonServiceServer can be embedded to have forward compatible implementations.
type UnimplementedSonServiceServer struct {
}

func (*UnimplementedSonServiceServer) Do(ctx context.Context, req *Stuff) (*Son, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Do not implemented")
}
func (*UnimplementedSonServiceServer) Belch(ctx context.Context, req *empty.Empty) (*Loudness, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Belch not implemented")
}

func RegisterSonServiceServer(s *grpc.Server, srv SonServiceServer) {
	s.RegisterService(&_SonService_serviceDesc, srv)
}

func _SonService_Do_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Stuff)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SonServiceServer).Do(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/ratatouille.SonService/Do",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SonServiceServer).Do(ctx, req.(*Stuff))
	}
	return interceptor(ctx, in, info, handler)
}

func _SonService_Belch_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(empty.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SonServiceServer).Belch(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/ratatouille.SonService/Belch",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SonServiceServer).Belch(ctx, req.(*empty.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

var _SonService_serviceDesc = grpc.ServiceDesc{
	ServiceName: "ratatouille.SonService",
	HandlerType: (*SonServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Do",
			Handler:    _SonService_Do_Handler,
		},
		{
			MethodName: "Belch",
			Handler:    _SonService_Belch_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "services.proto",
}
