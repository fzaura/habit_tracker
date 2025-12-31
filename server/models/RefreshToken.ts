export interface RefreshToken {
  id: string;
  userId: string;
  value: string;
  expiresAt: Date;
  createdAt: Date;
  updatedAt: Date;
}
