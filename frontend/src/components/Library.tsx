import React from "react";
import { Document, ThemeName, ThemeConfig } from "../types";

interface LibraryProps {
  documents: Document[];
  onCreateNew: () => void;
  onLoadDoc: (doc: Document) => void;
  onDeleteDoc: (docId: number) => void;
  theme: ThemeName;
  currentTheme: ThemeConfig;
}

export const Library: React.FC<LibraryProps> = ({ documents, onCreateNew, onLoadDoc, onDeleteDoc, theme, currentTheme }) => {
  return (
    <div className={`flex-1 ${currentTheme.bg} p-12 overflow-y-auto`}>
      <div className="max-w-5xl mx-auto">
        <div className="flex justify-between items-center mb-12">
          <h2 className={`text-3xl font-bold tracking-tight ${theme === 'paper' ? 'text-slate-800' : 'text-white'}`}>Project Library</h2>
          <button onClick={onCreateNew} className="px-6 py-2 bg-indigo-600 hover:bg-indigo-500 text-white rounded-full text-xs font-bold uppercase tracking-widest transition-all shadow-lg">New Analysis</button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {documents.map(doc => (
            <div key={doc.id} className="relative group">
              <div onClick={() => onLoadDoc(doc)} className={`${currentTheme.panel} border border-white/5 p-6 rounded-2xl cursor-pointer hover:border-indigo-500/40 transition-all group-hover:bg-white/5`}>
                <div className="text-[10px] font-mono text-indigo-500 uppercase mb-2 tracking-widest">{doc.language}</div>
                <h3 className={`text-xl font-bold mb-4 group-hover:text-indigo-400 ${theme === 'paper' ? 'text-slate-800' : 'text-white'}`}>{doc.title}</h3>
                <p className="text-slate-500 text-sm line-clamp-2 italic mb-6">"{doc.content}"</p>
                <div className="text-[9px] font-mono text-slate-700 uppercase">{Object.keys(doc.lexicon_json || {}).length} Tokens Indexed</div>
              </div>
              <button 
                onClick={(e) => { e.stopPropagation(); if(confirm('Delete document?')) onDeleteDoc(doc.id); }}
                className="absolute top-4 right-4 p-2 bg-red-500/10 hover:bg-red-500 text-red-500 hover:text-white rounded-full opacity-0 group-hover:opacity-100 transition-all z-10"
              >
                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
              </button>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
